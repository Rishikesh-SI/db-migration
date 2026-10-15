-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_hero_rating_rwid
-- Type: INDEX

-- Name: ix_pkl_hero_rating_rwid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_hero_rating_rwid ON labjfc.labjfc_hero_rating USING btree (rating_week_id);


--
