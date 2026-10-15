-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labtri; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labtri.labtri_rating_week USING btree (week_of_year);


--
