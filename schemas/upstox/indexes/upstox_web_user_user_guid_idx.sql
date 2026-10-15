-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_web_user_user_guid_idx
-- Type: INDEX

-- Name: upstox_web_user_user_guid_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE UNIQUE INDEX upstox_web_user_user_guid_idx ON upstox.upstox_web_user USING btree (user_guid);


--
