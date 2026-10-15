-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_gallery_approved_date
-- Type: INDEX

-- Name: idx_gallery_approved_date; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_gallery_approved_date ON labkc_v1.labkc_v1_gallery USING btree (approved_date) WHERE (status = (1)::numeric);


--
