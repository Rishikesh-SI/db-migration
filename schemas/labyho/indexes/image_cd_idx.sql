-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: image_cd_idx
-- Type: INDEX

-- Name: image_cd_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX image_cd_idx ON labyho.labyho_image USING btree (created_date DESC);


--
