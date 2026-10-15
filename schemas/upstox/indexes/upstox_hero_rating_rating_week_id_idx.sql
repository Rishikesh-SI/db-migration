-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_hero_rating_rating_week_id_idx
-- Type: INDEX

-- Name: upstox_hero_rating_rating_week_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_hero_rating_rating_week_id_idx ON upstox.upstox_hero_rating USING btree (rating_week_id);


--
