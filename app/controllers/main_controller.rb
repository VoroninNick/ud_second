class MainController < ApplicationController
  layout "landing", only: [:main]
  def main

  end

  def index

  end

  def favorites

  end

  def live_chat

  end

  def search

  end

  def profile_woman

  end

  def profile

  end

  def gifts

  end

  def mail_box

  end

  def second

  end

  def settings
    @months = %w[January February March April May June July August September October November December]

    # account_settings
    @active_section = :account_settings
    @active_content_key = :settings_account_settings_password_change

    # notification_settings
    @active_section = :account_settings
    @active_content_key = :settings_account_settings_profile_data


    @settings = {
      account_settings: {
          left_menu_items: {
              profile_data: {
                  name: "Profile data",
                  href: "#",
                  active: true,

              },
              buy_credits: {
                  name: "Buy credits",
                  href: "#"
              },
              my_credit_card: {
                  name: "My credit card",
                  href: "#"
              },
              purchase_history: {
                name: "Purchase history",
                href: "#"
              },
              membership_plan: {
                  name: "Membership plan",
                  href: "#"
              },
              email_settings:  {
                  name: "Email settings",
                  href: "#"
              },
              password_change: {
                  name: "Password change",
                  href: "#"
              },
              account_deactivation:  {
                  name: "Account deactivation",
                  href: "#"
              }
          },
          purchase_history: {
              table: {
                  columns: ["Time", "Operation", "Credits brought", "Price", "Status"],
                  rows: [
                            {
                              date_time: {
                                date: "25/03/2015",
                                time: "12:35:22"
                              },
                              operation: "Credits purchase",
                              credits_brought: 2500,
                              price: {
                                sum: 25.99,
                                currency: "$"
                              },
                              status: true
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "10:15:22"
                                },
                                operation: "Credits purchase",
                                credits_brought: 1000,
                                price: {
                                    sum: '10.50',
                                    currency: "$"
                                },
                                status: true
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "12:35:22"
                                },
                                operation: "membership plan renewal",
                                credits_brought: 2500,
                                price: {
                                    sum: 244.99,
                                    currency: "$"
                                },
                                status: true
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "12:35:22"
                                },
                                operation: "Credits purchase",
                                credits_brought: 2500,
                                price: {
                                    sum: 15.99,
                                    currency: "$"
                                },
                                status: true
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "12:35:22"
                                },
                                operation: "Credits purchase",
                                credits_brought: 2500,
                                price: {
                                    sum: "15.00",
                                    currency: "$"
                                },
                                status: false
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "12:35:22"
                                },
                                operation: "Credits purchase",
                                credits_brought: 2500,
                                price: {
                                    sum: 23.99,
                                    currency: "$"
                                },
                                status: true
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "12:35:22"
                                },
                                operation: "Upgrade to premium membership plan",
                                credits_brought: false,
                                price: {
                                    sum: 9.99,
                                    currency: "$"
                                },
                                status: true
                            },
                            {
                                date_time: {
                                    date: "25/03/2015",
                                    time: "12:35:22"
                                },
                                operation: "Credits purchase",
                                credits_brought: 2500,
                                price: {
                                    sum: 15.20,
                                    currency: "$"
                                },
                                status: true
                            }
                  ]
              }
          },
          profile_data: {
              birth_day: Date.new(1975, 12, 13),

          }
      },
      notification_settings: {
          left_menu_items: {
              notifications: {
                  name: "Notifications",
                  href: "#",
                  active: true,
              },
              popup_message: {
                  name: "Pop-up message",
                  href: "#"
              },
              notifications_stickers: {
                  name: "Notifications stickers"
              }
          }
      },
      view_settings: {
          left_menu_items: {
              test1: {
                  name: "Test 1"
              },
              test2: {
                  name: "Test 2"
              },
              test3: {
                  name: "Test 3"
              }
          }
      },
      other_settings: {
          left_menu_items: {
              test1: {
                  name: "Test 1"
              },
              test2: {
                  name: "Test 2"
              },
              test3: {
                  name: "Test 3"
              }
          }
      }
    }

    @membership_plan_settings = {
        current_plan_name: :premium,
        options: {
            user_search: {
                name: "User search",
                type: :boolean,
            },
            browse_ladies_profile: {
                name: "Browse ladies profile",
                type: :boolean,
            },
            see_who_visited_your_profile: {
                name: "See who visited your profile",
                type: :boolean
            },
            open_emails: {
                name: "Open emails",
                type: :string,
                help: "credits/email"
            },
            introduction_emails: {
                name: "Introduction emails",
                type: :string,
                help: "credits/email"
            },
            send_follow_up_emails: {
                name: "Send follow up emails",
                type: :string,
                help: "credits/email"
            },
            instant_messaging_service: {
                name: "Instant messaging service (Chat)",
                type: :string,
                help: "credits/email"
            },
            instant_messaging_with_live_video: {
                name: "Instant messaging with live video",
                type: :string,
                help: "credits/email"
            },
            instant_messaging_with_cam_share: {
                name: "Instant messaging with CamShare",
                type: :string,
                help: "credits/email"
            },
            discount_of_live_chat: {
                name: "~50% Off Live Chat",
                type: :boolean
            },
            discount_of_video_streaming: {
                name: "~50% Off Video Streaming",
                type: :boolean
            },
            discount_of_cam_share: {
                name: "~50% Off CamShare",
                type: :boolean
            },
            access_to_trip_advisor: {
                name: "Access to",
                type: :boolean,
                help: "Trip Advisor and travel assistance from Travel coordinator"
            },
            access_to_custom_support: {
                name: "Access to",
                type: :boolean,
                help: "Custom support / Web-hosting / Match-up survey"
            }
        },
        plans: {
            free: {
                name: "Free",
                available: true,
                valid_for_a_week: true,
                starting_plan: true,
                options: {
                    user_search: true,
                    browse_ladies_profile: true ,
                    see_who_visited_your_profile: true,
                    open_emails: 10,
                    introduction_emails: 10,
                    send_follow_up_emails: 10,
                    instant_messaging_service: 2,
                    instant_messaging_with_live_video: 4,
                    instant_messaging_with_cam_share: 8,
                    discount_of_live_chat: false,
                    discount_of_video_streaming: false,
                    discount_of_cam_share: false,
                    access_to_trip_advisor: false,
                    access_to_custom_support: true
                }
            },
            standard: {
                name: "Standard",
                available: true,
                price: "$27.99",
                price_per: "per month",
                options: {
                    user_search: true,
                    browse_ladies_profile: true ,
                    see_who_visited_your_profile: true,
                    open_emails: :unlimited,
                    introduction_emails: ["15 Free", "5"],
                    send_follow_up_emails: 10,
                    instant_messaging_service: [{group: :next}, 1],
                    instant_messaging_with_live_video: [{group_data: "30 Free"}, 2],
                    instant_messaging_with_cam_share: [{group: :prev}, 4],
                    discount_of_live_chat: true,
                    discount_of_video_streaming: true,
                    discount_of_cam_share: true,
                    access_to_trip_advisor: true,
                    access_to_custom_support: true
                }
            },
            premium: {
                name: "Premium",
                available: true,
                allow_renew: true,
                price: "$48.99",
                price_per: "per month",
                options: {
                    user_search: true,
                    browse_ladies_profile: true ,
                    see_who_visited_your_profile: true,
                    open_emails: :unlimited,
                    introduction_emails: ["30 Free", 5],
                    send_follow_up_emails: 10,
                    instant_messaging_service: [{group: :next}, 1],
                    instant_messaging_with_live_video:[{group_data: "60 Free"}, 2],
                    instant_messaging_with_cam_share: [{group: :prev}, 4],
                    discount_of_live_chat: true,
                    discount_of_video_streaming: true,
                    discount_of_cam_share: true,
                    access_to_trip_advisor: true,
                    access_to_custom_support: true
                }
            }
        }
    }
  end
end
