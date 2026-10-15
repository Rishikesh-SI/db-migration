-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: idx_sibot_user_id
-- Type: INDEX

-- Name: idx_sibot_user_id; Type: INDEX; Schema: sibot; Owner: -
--

CREATE INDEX idx_sibot_user_id ON sibot.sibot_user USING btree (user_id);


--
