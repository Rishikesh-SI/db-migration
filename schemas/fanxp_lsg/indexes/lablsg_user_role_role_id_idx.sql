-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_user_role_role_id_idx
-- Type: INDEX

-- Name: lablsg_user_role_role_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_user_role_role_id_idx ON fanxp_lsg.lablsg_user_role USING btree (role_id);


--
