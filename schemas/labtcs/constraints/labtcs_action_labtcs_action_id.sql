-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_action labtcs_action_id
-- Type: CONSTRAINT

-- Name: labtcs_action labtcs_action_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_action
    ADD CONSTRAINT labtcs_action_id PRIMARY KEY (action_id);


--
