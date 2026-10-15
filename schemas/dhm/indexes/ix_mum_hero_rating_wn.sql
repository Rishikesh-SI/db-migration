-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_hero_rating_wn
-- Type: INDEX

-- Name: ix_mum_hero_rating_wn; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_hero_rating_wn ON dhm.dhm_hero_rating USING btree (entity_role_map_id);


--
