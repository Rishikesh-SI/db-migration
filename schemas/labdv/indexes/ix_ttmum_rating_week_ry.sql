-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labdv.labdv_rating_week USING btree (rating_year);


--
