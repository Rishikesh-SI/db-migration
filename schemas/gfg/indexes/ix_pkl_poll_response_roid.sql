-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_poll_response_roid
-- Type: INDEX

-- Name: ix_pkl_poll_response_roid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_poll_response_roid ON gfg.gfg_poll_response USING btree (response_option_id);


--
