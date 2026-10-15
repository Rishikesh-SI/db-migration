-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_rating_week_wn
-- Type: INDEX

-- Name: ix_jafc_rating_week_wn; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_rating_week_wn ON jafc.jafc_rating_week USING btree (week_number);


--
