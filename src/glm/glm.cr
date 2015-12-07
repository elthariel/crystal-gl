require "./tvec3"
require "./tmet4"

# FIXME: propose moving these into Crystal std-library
struct Float32
  def self.zero
    0_f32
  end
  def self.one
    1_f32
  end
end
struct Float64
  def self.zero
    0_f64
  end
  def self.one
    1_f64
  end
end


module GLM
  def self.deg_to_rad(d)
    d / 180.0 * Math::PI
  end

  alias Mat4 = TMat4(Float32)
  alias Vec3 = TVec3(Float32)

  def self.vec3(x, y, z)
    Vec3.new x.to_f32, y.to_f32, z.to_f32
  end

  # OpenGL utility constructors

  def self.perspective(fov_y, aspect, near, far)
    raise ArgumentError.new if aspect == 0 || near == far
    rad = GLM.deg_to_rad(fov_y)
    tan_half_fov = Math.tan(rad / 2)

    m = Mat4.zero
    m[0,0] = 1 / (aspect * tan_half_fov).to_f32
    m[1,1] = 1 / tan_half_fov.to_f32
    m[2,2] = -(far + near).to_f32 / (far - near).to_f32
    m[3,2] = -1_f32
    m[2,3] = -(2_f32 * far * near) / (far - near)
    m
  end

  def self.look_at(eye : Vec3, center : Vec3, up : Vec3)
    f = (center - eye).normalize
    s = f.cross(up).normalize
    u = s.cross(f)

    m = Mat4.identity
    m[0,0] = s.x
    m[0,1] = s.y
    m[0,2] = s.z
    m[1,0] = u.x
    m[1,1] = u.y
    m[1,2] = u.z
    m[2,0] = -f.x
    m[2,1] = -f.y
    m[2,2] = -f.z
    m[0,3] = -s.dot(eye)
    m[1,3] = -u.dot(eye)
    m[2,3] = f.dot(eye)
    m
  end
end

