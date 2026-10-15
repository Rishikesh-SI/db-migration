-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_wn; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_wn ON labbsc_old.labbsc_hero_rating USING btree (entity_role_map_id);


--
