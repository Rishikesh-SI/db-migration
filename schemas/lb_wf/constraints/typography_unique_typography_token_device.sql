-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: typography unique_typography_token_device
-- Type: CONSTRAINT

-- Name: typography unique_typography_token_device; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.typography
    ADD CONSTRAINT unique_typography_token_device UNIQUE (token, device);


--
