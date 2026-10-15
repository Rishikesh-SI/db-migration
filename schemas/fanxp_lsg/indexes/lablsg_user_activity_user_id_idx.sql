-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_user_activity_user_id_idx
-- Type: INDEX

-- Name: lablsg_user_activity_user_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_user_activity_user_id_idx ON fanxp_lsg.lablsg_user_activity USING btree (user_id);


--
