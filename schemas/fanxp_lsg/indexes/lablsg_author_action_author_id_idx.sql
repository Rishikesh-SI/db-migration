-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_author_action_author_id_idx
-- Type: INDEX

-- Name: lablsg_author_action_author_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_author_action_author_id_idx ON fanxp_lsg.lablsg_author_action USING btree (author_id);


--
