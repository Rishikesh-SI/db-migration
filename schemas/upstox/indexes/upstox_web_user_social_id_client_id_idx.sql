-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_web_user_social_id_client_id_idx
-- Type: INDEX

-- Name: upstox_web_user_social_id_client_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_web_user_social_id_client_id_idx ON upstox.upstox_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
