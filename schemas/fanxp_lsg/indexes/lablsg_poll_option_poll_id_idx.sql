-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_poll_option_poll_id_idx
-- Type: INDEX

-- Name: lablsg_poll_option_poll_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_poll_option_poll_id_idx ON fanxp_lsg.lablsg_poll_option USING btree (poll_id);


--
