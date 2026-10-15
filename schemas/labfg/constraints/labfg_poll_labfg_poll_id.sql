-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_poll labfg_poll_id
-- Type: CONSTRAINT

-- Name: labfg_poll labfg_poll_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_poll
    ADD CONSTRAINT labfg_poll_id PRIMARY KEY (poll_id);


--
