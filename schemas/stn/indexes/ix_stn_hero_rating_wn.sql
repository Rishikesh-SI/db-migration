-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_hero_rating_wn
-- Type: INDEX

-- Name: ix_stn_hero_rating_wn; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_hero_rating_wn ON stn.stn_hero_rating USING btree (entity_role_map_id);


--
