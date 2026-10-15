-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labisp.labisp_hero_rating USING btree (rating_week_id);


--
