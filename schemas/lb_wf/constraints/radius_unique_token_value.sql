-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: radius unique_token_value
-- Type: CONSTRAINT

-- Name: radius unique_token_value; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.radius
    ADD CONSTRAINT unique_token_value UNIQUE (token, value);


--
