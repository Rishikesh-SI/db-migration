-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labos; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labos.labos_rating_week USING btree (rating_year);


--
