-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labmcfc.labmcfc_rating_week USING btree (week_of_year);


--
