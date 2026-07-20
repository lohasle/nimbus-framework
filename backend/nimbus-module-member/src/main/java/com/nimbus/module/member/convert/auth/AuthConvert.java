package com.nimbus.module.member.convert.auth;

import com.nimbus.module.member.controller.app.auth.vo.*;
import com.nimbus.module.member.controller.app.social.vo.AppSocialUserUnbindReqVO;
import com.nimbus.module.member.controller.app.user.vo.AppMemberUserResetPasswordReqVO;
import com.nimbus.framework.common.biz.system.oauth2.dto.OAuth2AccessTokenRespDTO;
import com.nimbus.module.system.api.sms.dto.code.SmsCodeSendReqDTO;
import com.nimbus.module.system.api.sms.dto.code.SmsCodeUseReqDTO;
import com.nimbus.module.system.api.sms.dto.code.SmsCodeValidateReqDTO;
import com.nimbus.module.system.api.social.dto.SocialUserBindReqDTO;
import com.nimbus.module.system.api.social.dto.SocialUserUnbindReqDTO;
import com.nimbus.module.system.api.social.dto.SocialWxJsapiSignatureRespDTO;
import com.nimbus.module.system.enums.sms.SmsSceneEnum;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AuthConvert {

    AuthConvert INSTANCE = Mappers.getMapper(AuthConvert.class);

    SocialUserBindReqDTO convert(Long userId, Integer userType, AppAuthSocialLoginReqVO reqVO);
    SocialUserUnbindReqDTO convert(Long userId, Integer userType, AppSocialUserUnbindReqVO reqVO);

    SmsCodeSendReqDTO convert(AppAuthSmsSendReqVO reqVO);
    SmsCodeUseReqDTO convert(AppMemberUserResetPasswordReqVO reqVO, SmsSceneEnum scene, String usedIp);
    SmsCodeUseReqDTO convert(AppAuthSmsLoginReqVO reqVO, Integer scene, String usedIp);

    AppAuthLoginRespVO convert(OAuth2AccessTokenRespDTO bean, String openid);

    SmsCodeValidateReqDTO convert(AppAuthSmsValidateReqVO bean);

    SocialWxJsapiSignatureRespDTO convert(SocialWxJsapiSignatureRespDTO bean);

}
