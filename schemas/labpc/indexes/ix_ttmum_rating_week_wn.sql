-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labpc.labpc_rating_week USING btree (week_number);


--
