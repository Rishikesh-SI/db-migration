-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labmi_beta_22042024.labmi_poll_response USING btree (response_option_id);


--
