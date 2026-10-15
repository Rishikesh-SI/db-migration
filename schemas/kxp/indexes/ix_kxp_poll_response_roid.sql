-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_poll_response_roid
-- Type: INDEX

-- Name: ix_kxp_poll_response_roid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_poll_response_roid ON kxp.kxp_poll_response USING btree (response_option_id);


--
