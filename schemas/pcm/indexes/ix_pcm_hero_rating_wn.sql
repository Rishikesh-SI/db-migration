-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_hero_rating_wn
-- Type: INDEX

-- Name: ix_pcm_hero_rating_wn; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_hero_rating_wn ON pcm.pcm_hero_rating USING btree (entity_role_map_id);


--
