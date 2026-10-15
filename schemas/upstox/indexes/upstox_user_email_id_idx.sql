-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_user_email_id_idx
-- Type: INDEX

-- Name: upstox_user_email_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_user_email_id_idx ON upstox.upstox_user USING btree (email_id);


--
