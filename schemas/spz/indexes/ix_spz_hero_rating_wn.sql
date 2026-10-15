-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_hero_rating_wn
-- Type: INDEX

-- Name: ix_spz_hero_rating_wn; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_hero_rating_wn ON spz.spz_hero_rating USING btree (entity_role_map_id);


--
