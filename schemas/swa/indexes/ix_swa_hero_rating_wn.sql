-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_hero_rating_wn
-- Type: INDEX

-- Name: ix_swa_hero_rating_wn; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_hero_rating_wn ON swa.swa_hero_rating USING btree (entity_role_map_id);


--
