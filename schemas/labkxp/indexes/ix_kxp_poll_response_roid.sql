-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_poll_response_roid
-- Type: INDEX

-- Name: ix_kxp_poll_response_roid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_poll_response_roid ON labkxp.labkxp_poll_response USING btree (response_option_id);


--
