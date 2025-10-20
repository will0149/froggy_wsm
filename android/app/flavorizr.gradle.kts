import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("development") {
            dimension = "flavor-type"
            applicationId = "com.atheneox.froggy_soft"
            resValue(type = "string", name = "app_name", value = "FroggySoft Dev")
            resValue(type = "string", name = "base_url", value = "https//cct-api-dev.froggysoft.app")
        }
        create("stage") {
            dimension = "flavor-type"
            applicationId = "com.atheneox.froggy_soft"
            resValue(type = "string", name = "app_name", value = "FroggySoft STG")
            resValue(type = "string", name = "base_url", value = "https//cct-api-stg.froggysoft.app")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "com.atheneox.froggy_soft"
            resValue(type = "string", name = "app_name", value = "FroggySoft")
            resValue(type = "string", name = "base_url", value = "https//cct-api-dev.froggysoft.app")
        }
    }
}