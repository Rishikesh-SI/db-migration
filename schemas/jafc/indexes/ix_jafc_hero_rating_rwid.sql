-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_hero_rating_rwid
-- Type: INDEX

-- Name: ix_jafc_hero_rating_rwid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_hero_rating_rwid ON jafc.jafc_hero_rating USING btree (rating_week_id);


--
