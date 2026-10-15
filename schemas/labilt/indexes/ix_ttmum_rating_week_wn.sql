-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labilt.labilt_rating_week USING btree (week_number);


--
