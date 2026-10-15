-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_user_event_subscription_map_mi
-- Type: TABLE ATTACH

-- Name: gpn_user_event_subscription_map_mi; Type: TABLE ATTACH; Schema: gpn_v2; Owner: -
--

ALTER TABLE ONLY gpn_v2.gpn_user_event_subscription_map ATTACH PARTITION gpn_v2.gpn_user_event_subscription_map_mi FOR VALUES FROM ('19') TO ('22');


--
