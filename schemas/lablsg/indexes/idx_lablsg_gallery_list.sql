-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: idx_lablsg_gallery_list
-- Type: INDEX

-- Name: idx_lablsg_gallery_list; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX idx_lablsg_gallery_list ON lablsg.lablsg_gallery USING btree (is_deleted, is_active, status, updated_date DESC);


--
