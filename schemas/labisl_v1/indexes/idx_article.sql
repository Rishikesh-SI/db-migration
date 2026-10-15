-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: idx_article
-- Type: INDEX

-- Name: idx_article; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX idx_article ON labisl_v1.labisl_v1_article USING btree (published_date);


--
