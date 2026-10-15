-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: idx_mv_user_activity
-- Type: INDEX

-- Name: idx_mv_user_activity; Type: INDEX; Schema: labrao; Owner: -
--

CREATE UNIQUE INDEX idx_mv_user_activity ON labrao.mv_user_activity USING btree (user_activity_id);


--
