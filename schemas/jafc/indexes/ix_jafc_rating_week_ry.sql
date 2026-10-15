-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_rating_week_ry
-- Type: INDEX

-- Name: ix_jafc_rating_week_ry; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_rating_week_ry ON jafc.jafc_rating_week USING btree (rating_year);


--
