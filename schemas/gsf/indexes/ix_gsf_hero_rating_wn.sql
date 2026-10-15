-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_hero_rating_wn
-- Type: INDEX

-- Name: ix_gsf_hero_rating_wn; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_hero_rating_wn ON gsf.gsf_hero_rating USING btree (entity_role_map_id);


--
