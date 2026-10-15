-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_hero_rating_wn
-- Type: INDEX

-- Name: ix_jafc_hero_rating_wn; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_hero_rating_wn ON jafc.jafc_hero_rating USING btree (entity_role_map_id);


--
