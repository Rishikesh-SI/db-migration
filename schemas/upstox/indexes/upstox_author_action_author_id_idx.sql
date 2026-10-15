-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_author_action_author_id_idx
-- Type: INDEX

-- Name: upstox_author_action_author_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_author_action_author_id_idx ON upstox.upstox_author_action USING btree (author_id);


--
