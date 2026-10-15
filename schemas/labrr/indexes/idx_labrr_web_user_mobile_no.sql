-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: idx_labrr_web_user_mobile_no
-- Type: INDEX

-- Name: idx_labrr_web_user_mobile_no; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX idx_labrr_web_user_mobile_no ON labrr.labrr_web_user USING btree (mobile_no);


--
