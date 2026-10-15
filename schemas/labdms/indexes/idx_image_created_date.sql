-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: idx_image_created_date
-- Type: INDEX

-- Name: idx_image_created_date; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX idx_image_created_date ON labdms.labdms_image USING btree (created_date DESC);


--
