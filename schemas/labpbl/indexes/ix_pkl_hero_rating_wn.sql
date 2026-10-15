-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_hero_rating_wn
-- Type: INDEX

-- Name: ix_pkl_hero_rating_wn; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_hero_rating_wn ON labpbl.labpbl_hero_rating USING btree (entity_role_map_id);


--
