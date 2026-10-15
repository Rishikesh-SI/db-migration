-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_poll_response_roid
-- Type: INDEX

-- Name: ix_kxp_poll_response_roid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_poll_response_roid ON labstlz.labstlz_poll_response USING btree (response_option_id);


--
