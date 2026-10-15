-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_kxp_poll_response_roid
-- Type: INDEX

-- Name: ix_kxp_poll_response_roid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_kxp_poll_response_roid ON labmcfc.labmcfc_poll_response USING btree (response_option_id);


--
