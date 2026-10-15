-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_rating_week_wn
-- Type: INDEX

-- Name: ix_pkl_rating_week_wn; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_rating_week_wn ON labjfc.labjfc_rating_week USING btree (week_number);


--
