-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_hero_rating_wn
-- Type: INDEX

-- Name: ix_abp_hero_rating_wn; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_hero_rating_wn ON abpp.abp_hero_rating USING btree (entity_role_map_id);


--
