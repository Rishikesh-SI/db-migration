-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_action cli_stp_v1_action_id
-- Type: CONSTRAINT

-- Name: cli_stp_v1_action cli_stp_v1_action_id; Type: CONSTRAINT; Schema: cli_stp_v1; Owner: -
--

ALTER TABLE ONLY cli_stp_v1.cli_stp_v1_action
    ADD CONSTRAINT cli_stp_v1_action_id PRIMARY KEY (action_id);


--
