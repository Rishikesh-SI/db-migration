-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_hero_rating_wn
-- Type: INDEX

-- Name: ix_ppb_hero_rating_wn; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_hero_rating_wn ON ppb.ppb_hero_rating USING btree (entity_role_map_id);


--
